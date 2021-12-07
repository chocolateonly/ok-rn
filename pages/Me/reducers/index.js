import types from '../types';
export const initAddress={
    province: '',
    city: '',
    area: '',
    address: '',
    names: '',
    mobile: '',
    istate: 0,
}

const initialState = {
    profile: {
        uid: '',
        username: '',
        pic: '',
        nickname: '',
        mobile: '',
        money: '',
//fixme:生日 性别 对应字段
        _birthdate:'2020-12-30',
        _sex_isMale:false
    },
    addressList: [],
    address: {
        ...initAddress
    },
    coupons:[],
    orderDetails:{},
    express_info:[]
};
const MeReducer = (state = initialState, action) => {
    switch (action.type) {
        case types.GET_PROFILE_INFO: {
            return {
                ...state,
                profile: {...state.profile,...action.data},
            };
        }
        case types.UPDATE_USER_IMG: {
            return {
                ...state,
                profile:{...state.profile,pic:action.data} ,
            };
        }
        case types.UPDATE_USER_NAME: {
            return {
                ...state,
                profile:{...state.profile,nickname:action.data} ,
            };
        }
        case types.UPDATE_USER_PHONE: {
            return {
                ...state,
                profile:{...state.profile,mobile: action.data} ,
            };
        }
        case types.GET_ADDRESS_LIST: {
            return {
                ...state,
                addressList: action.data || [],
            };
        }
        case types.ADD_OR_UPDATE_ADDRESS: {
            return {
                ...state,
                address: {...state.address,...action.data}
            };
        }
        case types.SET_MY_COUPONS:{
            return {
                ...state,
                coupons:action.data
            }
        }
        case types.GET_ORDER_DETAILS:{
            return {
                ...state,
                orderDetails:action.data
            }
        }
        case types.SET_EXPRESS_INFO:{
            return {
                ...state,
                express_info:action.data
            }
        }
        case types.CLEAR_ME_DATA:{
            return initialState
        }
        default:
            return state;
    }
};

export default MeReducer;
