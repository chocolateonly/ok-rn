import React from 'react'
import {createStackNavigator} from "@react-navigation/stack";
import Forum from '../../../pages/Forum';
const AdvisoryStack = createStackNavigator();
export default function CoursesStack() {
  return (
    <AdvisoryStack.Navigator>
      <AdvisoryStack.Screen name="Forum" component={Forum}/>
    </AdvisoryStack.Navigator>
  );
}
