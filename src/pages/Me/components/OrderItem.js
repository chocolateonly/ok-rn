import React, {useState, useEffect} from 'react';
import {
    StyleSheet,
    View,
    TouchableOpacity,
    Text,
} from 'react-native';
import {commonStyle} from '../../../common/styles';

const OrderItem = ({item, index, onItemPress}) => {

    return (
        <View style={[styles.orderItemWrapper, {marginTop: 10}]}>

            <View style={styles.flexSpaceBetween}>
                <Text style={styles.orderHeaderNum}>订单号：{item.order_id}</Text>
                <Text style={styles.orderHeaderCreatTime}>{item.createTime}</Text>
            </View>


            <View style={styles.orderGoods}>
                <View style={commonStyle.flexSpaceBetween}>
                    <Text style={styles.goodName}>{item.proname}</Text>
                    <Text style={styles.goodPrice}>￥{item.paymoney}</Text>
                </View>
                <Text style={styles.goodFun}>{item.obj}</Text>
                <View style={{flexDirection: 'row', alignItems: 'flex-end'}}>
                    <Text style={styles.orderGoodsNum}>共{item.totalnum}件商品</Text>
                    <Text style={styles.orderTotalPriceTitle}>实付款：</Text>
                    <Text style={styles.orderTotalPrice}>￥{item.total}</Text>
                </View>
            </View>


            <View style={[styles.flexSpaceBetween, {justifyContent: 'flex-end'}]}>


                <TouchableOpacity onPress={() => onItemPress(item)} style={[
                    styles.orderItemButton,
                    item.status === '待付款' ? styles.orderItemButton_dfk :
                        item.status === '待发货' ? styles.orderItemButton_yfk :
                            item.status === '待收货' ? styles.orderItemButton_dfh :
                                styles.orderItemButton_yfh,
                ]
                }>
                    <Text style={{
                        color: item.status === '待付款' ? '#fff' :
                            item.status === '待发货' ? commonStyle.themeColor :
                                item.status === '待收货' ? commonStyle.font_Gray_color :
                                    commonStyle.font_Gray_color,
                    }}>{item.status}</Text>
                </TouchableOpacity>
            </View>

        </View>
    );

};

export default OrderItem;


const styles = StyleSheet.create({
    orderItemWrapper: {
        marginHorizontal: 10,
        backgroundColor: '#fff',
        borderRadius: 10,
        padding: 10,
    },
    flexSpaceBetween: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    orderHeaderNum: {},
    orderHeaderCreatTime: {
        color: '#999999',
    },
    orderGoods: {marginTop: 10},
    goodName: {fontSize: 16},
    goodFun: {color: '#999', marginVertical: 5},
    goodPrice: {},
    orderGoodsNum: {color: '#999', marginRight: 5},
    orderTotalPriceTitle: {fontSize: 16},
    orderTotalPrice: {fontSize: 16, color: '#E86718'},
    orderItemButton: {
        fontSize: 15,
        color: '#fff',
        backgroundColor: commonStyle.themeColor,
        paddingHorizontal: 20,
        paddingVertical: 6, borderRadius: 20,
        borderWidth: 1,
        borderColor: '#fff',
    },
    orderItemButton_dfk: {},
    orderItemButton_yfk: {
        backgroundColor: '#fff',
        borderWidth: 1,
        borderColor: commonStyle.themeColor,
        color: commonStyle.themeColor,
    },
    orderItemButton_yfh: {
        backgroundColor: '#fff',
        borderWidth: 1,
        borderColor: '#ccc',
        color: commonStyle.font_Gray_color,
    },
    orderItemButton_dfh: {
        backgroundColor: '#fff',
        borderWidth: 1,
        borderColor: '#ccc',
        color: commonStyle.font_Gray_color,
    },
});
