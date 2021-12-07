import types from '../types/login';

const initialState = {
    token: '',
    uid:''
};
const LoginReducer = (state = initialState, action) => {
    switch (action.type) {
        case types.GET_USER_INFO: {
            return {...state,...action.data,uid:action.data.id};
        }
        case types.CLEAR_LOGIN_DATA:{
            return initialState
        }
        default :
            return state;
    }
};
export default LoginReducer;
