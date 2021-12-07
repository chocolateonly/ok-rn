import types from './../types/login'
export default {
  getUserInfo:val=>({type:types.GET_USER_INFO,data:val}),
  clearLoginData:val=>({type:types.CLEAR_LOGIN_DATA,data:val}),
}
