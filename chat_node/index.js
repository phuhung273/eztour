const httpServer = require('http').createServer();
const io = require('socket.io')(httpServer, {
  cors: {
    origin: 'http://localhost:8080',
  },
});

const crypto = require('crypto');
const randomId = () => crypto.randomBytes(8).toString('hex');

const { InMemoryUserStore } = require('./userStore');
const userStore = new InMemoryUserStore();

const CONNECTED = 1;
const DISCONNECTED = 0;

io.use((socket, next) => {
  const sessionID = socket.handshake.auth.sessionID;
  if (sessionID) {
    const user = userStore.findUserBySessionId(sessionID);
    if (user) {
      socket.sessionID = sessionID;
      socket.userID = user.userID;
      socket.username = user.username;
      return next();
    }
  }
  const username = socket.handshake.auth.username;
  const userID = socket.handshake.auth.userID;
  if (!username || !userID) {
    return next(new Error('invalid credential'));
  }
  socket.sessionID = randomId();
  socket.userID = userID;
  socket.username = username;
  next();
});

io.on('connection', (socket) => {
  // persist session
  userStore.saveUser(socket.userID, {
    userID: socket.userID,
    sessionID: socket.sessionID,
    username: socket.username,
    connected: CONNECTED,
  });

  // emit session details
  socket.emit('session', {
    sessionID: socket.sessionID,
    userID: socket.userID,
  });

  // join the "userID" room
  socket.join(socket.userID);

  // fetch existing users
  const users = userStore.findAllUsers();
  socket.emit('users', {users});

  // notify existing users
  socket.broadcast.emit('user connected', {
    userID: socket.userID,
    username: socket.username,
    connected: CONNECTED,
    messages: [],
  });

  // forward the private message to the right recipient (and to other tabs of the sender)
  socket.on('private message', ({ content, to }) => {
    const message = {
      content,
      from: socket.userID,
      to,
    };
    socket.to(to).to(socket.userID).emit('private message', message);
  });

  // notify users upon disconnection
  socket.on('disconnect', async () => {
    const matchingSockets = await io.in(socket.userID).allSockets();
    const isDisconnected = matchingSockets.size === 0;
    if (isDisconnected) {
      // notify other users
      socket.broadcast.emit('user disconnected', {userID: socket.userID});
      // update the connection status of the session
      userStore.saveUser(socket.userID, {
        userID: socket.userID,
        sessionID: socket.sessionID,
        username: socket.username,
        connected: DISCONNECTED,
      });
    }
  });
});

const PORT = process.env.PORT || 3000;

httpServer.listen(PORT, () =>
  console.log(`server listening at *:${PORT}`)
);