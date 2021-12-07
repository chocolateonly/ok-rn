import types from '../types'
export default {
 getProfileInfo:val=>({type:types.GET_PROFILE_INFO,data:val}),
 setUserImg:val=>({type:types.UPDATE_USER_IMG,data:val}),
 setUserName:val=>({type:types.UPDATE_USER_NAME,data:val}),
 setUserPhone:val=>({type:types.UPDATE_USER_PHONE,data:val}),

 getAddressList:val=>({type:types.GET_ADDRESS_LIST,data:val}),
 addOrEditAddress:val=>({type:types.ADD_OR_UPDATE_ADDRESS,data:val}),
 setCoupons:val=>({type:types.SET_MY_COUPONS,data:val}),
 getOrderDetails:val=>({type:types.GET_ORDER_DETAILS,data:val}),
 setExpressInfo:val=>({type:types.SET_EXPRESS_INFO,data:val}),

 clearMeData:val=>({type:types.CLEAR_ME_DATA,data:val}),
}
