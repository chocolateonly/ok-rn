import React from 'react';
import {connect} from "react-redux";
import {ActivityIndicator} from '@ant-design/react-native';

const Loading = props => {
  const {loading} = props;
  return (<>
      {loading.isLoading && <ActivityIndicator toast text={loading.loadingText}/>}
    </>
  )
};

const mapStateToProps = state => {
  return {
    loading: state.GlobalReducer
  }
};
export default connect(
  mapStateToProps
)(Loading);
