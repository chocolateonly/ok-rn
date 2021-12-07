import types from './../types';
import _ from 'lodash';

const initialState = {
    answer: {
        birthDate: '',
        isMale: true,
        imgList: [],
        answerOptions: [],
    },
    diseaseTypes: [],
    questionList: [],
    result: {},
    confirmOrderInfo: {
        product: {},
        address: {
            ID:'',
            username:'',
            mobile:'',
            address:''
        },
        coupons: [],
        coupon: {},
        totalNumber: 1,
        totalMoney: '0.00',
        finallyMoney: '0.00',
    },
    orderInfo: {},

};

const HomeReducer = (state = initialState, action) => {
    switch (action.type) {
        case types.GET_DISEASE_TYPES: {
            return {...state, diseaseTypes: action.data};
        }
        case types.GET_QUESTION_LIST: {
            return {...state, questionList: action.data};
        }
        case types.SET_USER_ANSWER: {
            if (Object.keys(action.data).includes('img')) {
              let imgList=[]
              imgList=[...state.answer.imgList,action.data.img];
              return {
                ...state,
                answer:{...state.answer,imgList}
              }
            }

            return {
                ...state,
                answer: {...state.answer, ...action.data},
            };
        }
        case types.SET_ANSWER_RESULT: {
            return {
                ...state,
                result: action.data,
            };
        }
        case types.SET_CONFIRM_ORDER_INFO: {
            return {
                ...state,
                confirmOrderInfo: {...state.confirmOrderInfo, ...action.data},
            };
        }
        case types.COMPUTE_ORDER_MONEY: {//totalNumber 改变 操作
            const {coupons = [], totalNumber, product, selected_coupon_id = ''} = action.data;
            const p_money = product.money; //单价
            const totalMoney = totalNumber * Number(p_money); //总金额

            let coupon = {}; //优惠券
            let finallyMoney = ''; //折扣后最终价
            let couponsList = [];  //可用的

            if (selected_coupon_id) {
                //用户自己选择的
                coupon = coupons.filter(item => item.id === selected_coupon_id)[0];
            } else {
                //设置默认的
                if (coupons.length > 0) {
                    couponsList = coupons.filter((item) => Number(item.total) <= Number(totalMoney));
                    couponsList = couponsList.sort((a, b) => b - a);
                    coupon = couponsList.length > 0 ? couponsList[0] : {};
                }
            }

            const descase = _.isEmpty(coupon) ? 0 : Number(coupon.descase);  //优惠额
            finallyMoney = Number(totalMoney - descase).toFixed(2);
            return {
                ...state,
                confirmOrderInfo: {
                    ...state.confirmOrderInfo,
                    totalNumber,
                    coupon,
                    coupons: coupons.sort((a, b) => Number(a.total) - Number(b.total)),
                    totalMoney: Number(totalMoney).toFixed(2),
                    finallyMoney,
                },
            };
        }
        case types.GET_ORDER_INFO: {
            return {
                ...state,
                orderInfo: action.data,
            };
        }
        case types.CLEAR_HOME_DATA:{
            return initialState
        }
        default:
            return state;
    }
};
export default HomeReducer;
