import types from './../types'
export default {
    getDiseasesList:val=>({type:types.GET_DISEASE_TYPES,data:val}),
    setQuestionList:val=>({type:types.GET_QUESTION_LIST,data:val}),
    setUserAnswer:val=>({type:types.SET_USER_ANSWER,data:val}),
    setAnswerResult:val=>({type:types.SET_ANSWER_RESULT,data:val}),
    setConfirmOrderOInfo:val=>({type:types.SET_CONFIRM_ORDER_INFO,data:val}),
    getOrderInfo:val=>({type:types.GET_ORDER_INFO,data:val}),
    computeOrderMoney:val=>({type:types.COMPUTE_ORDER_MONEY,data:val}),
    clearHomeData:val=>({type:types.CLEAR_HOME_DATA,data:val}),
}
