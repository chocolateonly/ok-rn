import React from 'react'
import {View,StyleSheet,TouchableOpacity} from 'react-native';
import {commonStyle} from '../common/styles';
import Text from './Text';

const ThemeCard = ({title = 'Title',titleStyle={}, rightCom = () => null,children=()=>null,onPressHeader=()=>null}) => {
    return (
        <View style={styles.themeCard}>
            <TouchableOpacity style={styles.themeCardHeader}
                              activeOpacity={1}
                              onPress={onPressHeader}>

                <View style={styles.headerWrapper}>
                    <Text style={styles.core}></Text>
                    <Text style={[styles.headerTitle,titleStyle]}>{title}</Text>
                </View>

                {rightCom()}
            </TouchableOpacity>

            <View style={styles.CardContent}>
                {children}
            </View>
        </View>
    );
};

export default ThemeCard
const styles = StyleSheet.create({
    themeCard: {
        minWidth:0,
        padding: 20,
        paddingVertical:30,
        marginHorizontal: 20,
        marginBottom: 20,
        backgroundColor: '#fff',
        borderRadius:10
    },
    themeCardHeader: {
        flex:1,
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    headerWrapper:{
        flex:1,
        flexDirection: 'row'
    },
    core: {
        width: 6,
        marginLeft:-21,
        backgroundColor: commonStyle.themeColor,
    },
    headerTitle: {
        fontSize: 18,
        marginLeft: 10,
        fontWeight:'bold'
    },
    CardContent: {
        marginTop: 10,
    },

});
