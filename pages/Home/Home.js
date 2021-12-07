import React, {useState, useEffect} from 'react';
import {useNavigation} from '@react-navigation/native';
import {commonStyle} from '../../common/styles';
import {connect} from 'react-redux';
import {ApiService} from '../../fetch/routes';
import globalActions from '../../global/actions';
import homeActions from './actions';
import LoadingPage from '../../global/LoadingPage';
import {BackHandler, Platform} from 'react-native';
import {Toast} from '@ant-design/react-native';

function HomeContainer(props) {
    const {me,getDiseasesList, setGlobalError, setIsLoadingPage,setUserAnswer} = props;
    const {profile}=me
    let lastBackPressed = null;
    const [time, setTime] = useState(0);
    const navigation = useNavigation();
    navigation.setOptions({
        headerTitle: '戒瘾小助理',
        ...commonStyle.header,
    });
    useEffect(()=>{
        setUserAnswer({birthDate:profile._birthdate,isMale:profile._sex_isMale})
    },[])
    const setDiseasesList = async () => {
        try {
            setIsLoadingPage(true);
            const res = await ApiService.getDiseasesList();
            getDiseasesList(res.data);
            setIsLoadingPage(false);
        } catch (e) {
            setIsLoadingPage(false);
            setGlobalError(e.errorMessage);
        }
    };

    useState(() => {
        (async () => await setDiseasesList())();
    });
    const onBack = () => {
        let now = new Date().getTime();
        if (now - lastBackPressed > 2500) {
            lastBackPressed = now;
            Toast.info('再按一次退出程序');
            return true;
        }
        BackHandler.exitApp();
        return true;

    };
    useEffect(() => {
        if (Platform.OS === 'android') {
            BackHandler.addEventListener('hardwareBackPress', onBack);
        }
        return () => {
            if (Platform.OS === 'android') {
                BackHandler.removeEventListener('hardwareBackPress');
            }
        };
    }, []);
    return (
        <LoadingPage>

        </LoadingPage>
    )
        ;
}

const mapStateToProps = state => {
    return {
        global: state.GlobalReducer,
        me:state.MeReducer
    };
};
const mapDispatchToProps = dispatch => {
    return {
        setGlobalLoading: val => dispatch(globalActions.setGlobalLoading(val)),
        setGlobalError: val => dispatch(globalActions.setGlobalError(val)),
        getDiseasesList: val => dispatch(homeActions.getDiseasesList(val)),
        setIsLoadingPage: val => dispatch(globalActions.setIsLoadingPage(val)),
        setUserAnswer: val => dispatch(homeActions.setUserAnswer(val)),
    };
};
export default connect(
    mapStateToProps,
    mapDispatchToProps,
)(HomeContainer);
