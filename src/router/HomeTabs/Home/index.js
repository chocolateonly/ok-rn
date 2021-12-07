import React from 'react'
import {createStackNavigator} from "@react-navigation/stack";
import Home from "../../../pages/Home/Home";
const HomeStack = createStackNavigator();
export default function HomeCom() {
  return (
    <HomeStack.Navigator>
      <HomeStack.Screen name="Home" component={Home}/>
    </HomeStack.Navigator>
  );
}