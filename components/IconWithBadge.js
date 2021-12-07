import React from 'react';
import {View, Text, Image} from 'react-native';
import Ionicons from 'react-native-vector-icons/Ionicons';

function IconWithBadge({isImage = false, focused, img = '', activeImg = '', name = '', badgeCount =0, color, size}) {
    return (
        <View style={{position: 'relative'}}>
            {isImage ?
                <>
                    {focused ? <Image style={{width:22,height:22}} source={activeImg}/>
                        : <Image style={{width:22,height:22}} source={img}/>
                    }</> :
                <Ionicons style={{textAlign: 'center'}} name={name} size={size} color={color}/>
            }

            {badgeCount > 0 && (
                <Text style={{
                    color: 'white', fontSize: 12, position: 'absolute',
                    left: 13,
                    top: -3,
                    backgroundColor: 'red',
                    borderRadius: 8,
                    paddingLeft: 6, paddingRight: 6, fontWeight: 'bold',
                }}>
                    {badgeCount}
                </Text>
            )}
        </View>
    );
}

export default IconWithBadge;
