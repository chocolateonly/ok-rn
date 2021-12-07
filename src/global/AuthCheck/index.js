import React, {Component} from 'react';
import {connect} from 'react-redux';
import {unauthorized} from '../../src/utils/enum';

const AuthCheck = props => {

    const {global, navigation} = props;
    if (global.error === unauthorized) {
        return navigation.navigate('Login');
    }
    return null;
};

const mapStateToProps = state => {
    return {global: state.GlobalReducer};
};

export default connect(
    mapStateToProps,
)(AuthCheck);
