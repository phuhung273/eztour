
class InMemoryUserStore {
  constructor() {
    this.users = [
      {
        userID: '1',
        sessionID: null,
        username: 'admin@gmail.com',
        connected: 0,
      },
      {
        userID: '2',
        sessionID: null,
        username: 'hoanganh@email.com',
        connected: 0,
      },
      {
        userID: '3',
        sessionID: null,
        username: 'phuocanh@email.com',
        connected: 0,
      },
      {
        userID: '4',
        sessionID: null,
        username: 'sonpham@email.com',
        connected: 0,
      }
    ];
  }
  
  findUserBySessionId(sessionID) {
    return this.users.find(item => item.sessionID === sessionID);
  }
  
  saveUser(userID, user) {
    this.users = this.users.map((item) => {
      return item.userID === userID ? user : item;
    });
  }
  
  findAllUsers() {
    return this.users;
  }
}
  
module.exports = {
  InMemoryUserStore
};