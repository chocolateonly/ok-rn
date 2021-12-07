const validator={
  phone:{
    test:/^1[34578]\d{9}$/,
    err:'请输入正确手机号'
  },
  emailValidator: {
    reg: /^[A-Za-z\d]+([-_.][A-Za-z\d]+)*@([A-Za-z\d]+[-.])+[A-Za-z\d]{2,4}$/,
    errMessage: 'Please input correct email address'
  },
}
export default validator