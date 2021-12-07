import React from 'react'
import {createStackNavigator} from "@react-navigation/stack";
import Courses from '../../../pages/Courses'
const AdvisoryStack = createStackNavigator();
export default function CoursesStack() {
  return (
    <AdvisoryStack.Navigator>
      <AdvisoryStack.Screen name="Courses" component={Courses}/>
    </AdvisoryStack.Navigator>
  );
}
