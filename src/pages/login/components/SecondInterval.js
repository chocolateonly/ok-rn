import React, {useState, useEffect, useRef} from 'react';

const SecondInterval = ({callback,duration}) => {
    const [second, setSecond] = useState(duration-1);
    let timeInterval =null;
    const tick = () => {
        //console.log(second);
        if (second === 0) {
            //console.log('over');
            clearInterval(timeInterval);
            callback()
            return;
        }
        setSecond(second - 1);
    };

    const interval = () => timeInterval = setInterval(() => tick(), 1000);
    useEffect(() => {
        if (second >= 0) {
            interval();
        }
        return ()=>clearInterval(timeInterval);
    });

    return second;
};
export default SecondInterval;
