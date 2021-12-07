import React from 'react'
import {createStackNavigator} from "@react-navigation/stack";
import Me from "../../../pages/Me/Me";
const MeStack = createStackNavigator();
export default function MeCom() {
  return (
    <MeStack.Navigator>
      <MeStack.Screen name="Me" component={Me} />
    </MeStack.Navigator>
  );
}