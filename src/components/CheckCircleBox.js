import React from 'react';
import FontAwesome from 'react-native-vector-icons/FontAwesome';
import Ionicons from 'react-native-vector-icons/Ionicons';
const CheckCircleBox = ({isChecked,activeColor='#ff9529'}) => {

    return (
        <>
            {isChecked ?
                <Ionicons name={'ios-checkmark-circle'} style={{fontSize: 28, color:activeColor }}/>:
                <Ionicons name={'ios-checkmark-circle-outline'} style={{fontSize: 28, color: '#ccc'}}/>
            }
        </>
    );
};

export default CheckCircleBox;
