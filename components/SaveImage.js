import React, {useState, useEffect} from 'react';
import {NativeModules} from 'react-native';

const Test = () => {
  const [isok, setOk] = useState(false);
  const onTest = async () => {
    const res = await NativeModules.SaveImage.saveImage('url');

  };
  useEffect(() => {
    (async () => await onTest())();
  }, []);

  return;
};

export default Test;
