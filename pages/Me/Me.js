import React, {useEffect, useLayoutEffect} from 'react';
import {
    StyleSheet,
    View,
    ScrollView,
    TouchableOpacity,
    Text,
    Image,
} from 'react-native';
import {commonStyle} from '../../common/styles';
import {useNavigation} from '@react-navigation/native';
import meActions from './actions';
import {connect} from 'react-redux';
import globalActions from '../../global/actions';
import LoadingPage from '../../global/LoadingPage';

const Profile = ({user, me, getProfileInfo, setCoupons, setGlobalLoading, setGlobalError, setIsLoadingPage}) => {
    const {profile} = me;
    const navigation = useNavigation();
    useLayoutEffect(() => {
        navigation.setOptions({
            headerTitle: '我的',
            headerRight: () => <TouchableOpacity onPress={() => navigation.navigate('MyInfo')}>
                <Image source={require('./../../assets/me/userinfo_set_icon.png')}
                       resizeMode={'contain'}
                       style={{width: 30, height: 30, marginRight: 20}}/>
            </TouchableOpacity>,
            ...commonStyle.header,
            headerStyle: {
                backgroundColor: commonStyle.themeColor,
                borderBottomWidth: 0,
                borderBottomColor: commonStyle.themeColor,
                elevation: 0, //remove android shadow
            },
        });
    });

    return (
        <LoadingPage>
            <ScrollView>


            </ScrollView>
        </LoadingPage>
    );

};

const mapStateToProps = state => {
    return {
        user: state.LoginReducer,
        global: state.GlobalReducer,
        me: state.MeReducer,
    };
};
const mapDispatchToProps = dispatch => {
    return {
        setCoupons: val => dispatch(meActions.setCoupons(val)),
        setGlobalLoading: val => dispatch(globalActions.setGlobalLoading(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),
        setIsLoadingPage: val => dispatch(globalActions.setIsLoadingPage(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(Profile);


const styles = StyleSheet.create({
    flexRow: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginTop: 10,
    },
    menuList: {
        minWidth: 0,
    },
    listItem: {
        flex: 1,
        flexDirection: 'row',
        alignItems: 'center',
        minWidth: 0,
        paddingVertical: 10,
        borderBottomWidth: 1,
        borderColor: '#eee',
    },
    listItemImg: {
        width: 30,
        height: 30,
        marginRight: 10,
    },
    listItemText: {
        flexGrow: 1,
        flexShrink: 1,  //空间不足，先压缩
        fontSize: 16,
        color: commonStyle.font_Gray_color,
    },
    listItemIcon: {
        marginRight: 6,
        fontSize: 30,
        color: '#ccc',
    },
});
