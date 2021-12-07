import React, {useEffect} from 'react';
import {
    StyleSheet,
    View,
    TouchableOpacity,
    Text,
    Image,
} from 'react-native';
import FontAwesome from 'react-native-vector-icons/FontAwesome';
import {commonStyle} from '../../../common/styles';
import LinearGradient from 'react-native-linear-gradient'
import {connect} from 'react-redux';

const HeaderView = ({me,navigation}) => {
    const {profile}=me
    const img=profile.pic?{uri:profile.pic}:require('../../../assets/me/userimg.png')
    return (
        <LinearGradient colors={[commonStyle.themeColor, 'rgba(140,190,246,1)']}
        style={styles.header}
        >
            <TouchableOpacity activeOpacity={0.8}  onPress={()=>navigation.navigate('MyInfo')}
                              style={{marginTop:-60,flex:1,flexDirection:'row', justifyContent: 'space-between', alignItems: 'center'}}>
            <View style={styles.infoWrapper}>
                <View style={styles.avatarContainer}>
                    <Image resizeMode={'cover'} style={{width: 80, height: 80, borderRadius:40,backgroundColor: '#fcc'}} source={img}/>
                </View>

                <Text style={styles.text}>{profile.username}</Text>

            </View>

            <FontAwesome style={styles.arrow} name={'angle-right'}/>
            </TouchableOpacity>

        </LinearGradient>
    );
};
const mapStateToProps = state => {
    return {
        me:state.MeReducer
    };
};
export default connect(
    mapStateToProps,
)(HeaderView)

const styles = StyleSheet.create({
    header: {
        height: 200,
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        backgroundColor: commonStyle.themeColor,
        paddingHorizontal:20,
        borderBottomLeftRadius:20,
        borderBottomRightRadius:20,
    },
    infoWrapper: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    avatarContainer: {
        justifyContent: 'center',
        alignItems: 'center',
    },
    text: {
        color: '#fff',
        fontSize: 24,
        marginLeft: 10,
    },
    arrow: {
        width: 20,
        height:30,
        fontSize: 30,
        color: '#fff',
    },
});
