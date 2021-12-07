import React from 'react';
import {
    StyleSheet,
    View,
    TouchableOpacity,
    Text
} from 'react-native';
import {commonStyle} from '../common/styles';

const tabs = ['全部', '待付款', '待发货', '待收货', '已收货'];

const Tabs = ({activeTab, getOrder}) => {

    return (
                <View style={styles.tabs}>
                    {tabs.map((item, index) => {
                        return <TouchableOpacity style={styles.tabItem}
                                                 key={index}
                                                 activeOpacity={0.6}
                                                 onPress={()=>getOrder(index)}>
                            <Text style={[styles.tab,{color:activeTab===index?commonStyle.themeColor:'#4b4b4b'}]}>{item}</Text>
                            <View style={[styles.core,{backgroundColor:activeTab===index?commonStyle.themeColor:'transparent'}]}/>
                        </TouchableOpacity>;
                    })}
                </View>
    );

};

export default Tabs;


const styles = StyleSheet.create({
    tabs: {
        flex:0,
        flexDirection: 'row',
        alignItems: 'center',
        justifyContent: 'space-around',
        backgroundColor: '#fff',
        borderBottomWidth:1,
        borderBottomColor:'#eee'
    },
    tabItem:{
        alignItems: 'center',
        justifyContent: 'space-around',
    },
    tab: {
        fontSize: 16,
        paddingVertical:10,
    },
    core: {
        width:40,
        height: 4,
        backgroundColor: '#fff',
    }
});
