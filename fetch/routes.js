import {Post,Get,Put,Delete} from './index'
import {apiBaseUrl} from "../utils/enum";
import qs from 'qs'

//发送手机验证码
function sendPhoneCode(params) {
  return Get(`${apiBaseUrl}/api/sms/send?${qs.stringify(params)}`)
}
function loginByPhoneCode(params){
  return Get(`${apiBaseUrl}/api/user/mobilenocodelogin?${qs.stringify(params)}`)
}
//mock
function sendPhoneCode1(params) {
  return Get(`${apiBaseUrl}/api/sms/send1?${qs.stringify(params)}`)
}
//微信登录
function weiXinLogin(params) {
   return Get(`${apiBaseUrl}/api/user/wxlogin?${qs.stringify(params)}`)
}
function loginOut(options) {
  return Get(`${apiBaseUrl}/api/user/logout`,options)
}
//home
function getDiseasesList(){
  return Get(`${apiBaseUrl}/api/disease/catalist`)
}
function getQuestionList(params,options){
  return Get(`${apiBaseUrl}/api/question/asklist?${qs.stringify(params)}`,options)
}
//me
function getProfileInfo(options){
  return Get(`${apiBaseUrl}/api/user/index`,options)
}
function updateUserInfo(params,options){
  return Get(`${apiBaseUrl}/api/user/profile?${qs.stringify(params)}`,options)
}
//address
function getMyAddressList(params,options){
  return Get(`${apiBaseUrl}/api/usercenter/addresslist?${qs.stringify(params)}`,options)
}
function addAddress(params,options){
  return Get(`${apiBaseUrl}/api/usercenter/addAddress?${qs.stringify(params)}`,options)
}
function updateAddress(params,options){
  return Get(`${apiBaseUrl}/api/usercenter/updateAddress?${qs.stringify(params)}`,options)
}
function getAddress(params,options){
  return Get(`${apiBaseUrl}/api/usercenter/detailaddress?${qs.stringify(params)}`,options)
}
function deleteAddress(params,options){
  return Get(`${apiBaseUrl}/api/usercenter/deleteaddress?${qs.stringify(params)}`,options)
}
//
function getResult(params) {
 return Get(`${apiBaseUrl}/api/products/getProduct?${qs.stringify(params)}`)
}
function addOrder(params,options) {
  return Get(`${apiBaseUrl}/api/buy/ConfirmOrder?${qs.stringify(params)}`,options)
}
function getMyCoupons(params,options) {
  return Get(`${apiBaseUrl}/api/usercenter/coupon?${qs.stringify(params)}`,options)
}
function pay(params,options) {
  return Get(`${apiBaseUrl}/api/buy/onlinePay?${qs.stringify(params)}`,options)
}
function onlinePay(params,options) {
  return Get(`${apiBaseUrl}/api/usercenter/onlinepay?${qs.stringify(params)}`,options)
}
//
function getOrderList(params,options) {
  return Get(`${apiBaseUrl}/api/usercenter/OrderStatus?${qs.stringify(params)}`,options)
}
function getOrderDetails(params,options) {
  return Get(`${apiBaseUrl}/api/usercenter/checkOrder?${qs.stringify(params)}`,options)
}
function deleteOrder(params,options) {
  return Get(`${apiBaseUrl}/api/usercenter/DelOrder?${qs.stringify(params)}`,options)
}
function getExpressInfo(params,options) {
  return Get(`${apiBaseUrl}/api/usercenter/checkWuliu?${qs.stringify(params)}`,options)
}
function getBillList(params,options) {
  return Get(`${apiBaseUrl}/api/user/getUserMoneylog?${qs.stringify(params)}`,options)
}
//
function platformIntro() {
return  Get(`${apiBaseUrl}/api/index/index`)
}
function uploadImg(body,options){
  return Post(`${apiBaseUrl}/api/common/upload`,body,options)
}
//ask
function getAskInfo(params,options) {
  return Get(`${apiBaseUrl}/api/service/index?${qs.stringify(params)}`,options)
}
function getAskOptions(params,options) {
  return Get(`${apiBaseUrl}/api/service/getwd?${qs.stringify(params)}`,options)
}
function getAskAnswer(params,options) {
  return Get(`${apiBaseUrl}/api/service/getOpwd?${qs.stringify(params)}`,options)
}
//验签
function checkSign(params) {
  return Get(`${apiBaseUrl}/api/usercenter/verSign?${qs.stringify(params)}`)
}
export const ApiService={
  //
  sendPhoneCode,
  sendPhoneCode1,
  loginByPhoneCode,
  weiXinLogin,
  loginOut,
  updateUserInfo,
  getDiseasesList,
  getQuestionList,

  getProfileInfo,

  getMyAddressList,
  addAddress,
  updateAddress,
  getAddress,
  deleteAddress,
  getResult,
  addOrder,
  uploadImg,
  getMyCoupons,
  pay,
  platformIntro,
  getOrderList,
  getOrderDetails,
  deleteOrder,
  getExpressInfo,
  getBillList,

  //ask
  getAskInfo,
  getAskOptions,
  getAskAnswer,
  onlinePay,
  checkSign
};
