import React from 'react';
import { StatusBar, View, SafeAreaView} from 'react-native';
import {commonStyle} from '../common/styles';

function SafeArea({children}) {
    return (
        <>
            <StatusBar backgroundColor={commonStyle.themeColor} barStyle="light-content" hidden={false}/>
            <SafeAreaView style={{
                flex: 1,
                flexGrow: 1,
                backgroundColor: '#fff'
            }}>
                <View
                    style={{
                        flex: 1,
                        flexGrow: 1,
                        flexShrink: 1,
                        backgroundColor: '#f5f5f5',
                    }}
                >
                    {children}
                </View>
            </SafeAreaView>
        </>
    );
}

export default SafeArea;
