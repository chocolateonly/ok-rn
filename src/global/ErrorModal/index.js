import React from 'react';
import {connect} from "react-redux";
import {Modal} from "@ant-design/react-native";
import {Text, View} from "react-native";
import _ from "lodash";
import actions from "../actions";
import {unauthorized} from './../../utils/enum';

const ErrorTip = props => {
  const {error, setError} = props;
  const handleOk=()=>{
    setError('')
  }
  const footerButtons = [
    {text: 'Ok', onPress: () =>handleOk() , style: {color: 'blue'}},
  ];
  return (
    <>
      {!_.isEmpty(error.error)&&error.error!==unauthorized ? <Modal
        title="提示"
        transparent
        onClose={() => {
        }}
        maskClosable
        visible={!_.isEmpty(error.error)}
        footer={footerButtons}
      >
        <View style={{paddingVertical: 20}}>
          <Text style={{textAlign: 'center', fontSize: 18}}>{error.error}</Text>
        </View>
      </Modal> : null}
    </>
  )
};

const mapStateToProps = state => {
  return {error: state.GlobalReducer}
};
const mapDispatchToProps = dispatch => {
  return {setError: val => dispatch(actions.setGlobalError(val))}
};
export default connect(
  mapStateToProps,
  mapDispatchToProps
)(ErrorTip);
