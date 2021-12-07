import {unauthorized} from '../utils/enum';

const defaultConfig = {
    headers: {'Content-Type': 'application/json; charset=UTF-8'},
};
const {headers} = defaultConfig;

export async function Post(url, body, options = {}) {
    try {
        let res = await fetch(url, {
            method: 'POST',
            headers: {...headers, ...options},
            body,
        });
        res = await getStatus(res);
        res = await parseJson(res);
        res = await handleRes(res);
        return res;
    } catch (e) {
        await Promise.reject({errorMessage: e.message});
    }
}

export async function Get(url, options = {}) {
    try {
        let res = await fetch(url, {
            method: 'GET',
            headers: {...headers, ...options},
        });
        res = await getStatus(res);
        res = await parseJson(res);
        res = await handleRes(res);
        return res;
    } catch (e) {
        await Promise.reject({errorMessage: e.message});
    }
}

export async function Put(url, body, options = {}) {
    try {
        let res = await fetch(url, {
            method: 'PUT',
            headers: {...headers, ...options},
            body,
        });

        res = await getStatus(res);
        res = await parseJson(res);
        res = await handleRes(res);
        return res;
    } catch (e) {
        await Promise.reject({errorMessage: e.message});
    }
}

export async function Delete(url, options = {}) {
    try {
        let res = await fetch(url, {
            method: 'DELETE',
            headers: {...headers, ...options},
        });

        res = await getStatus(res);
        res = await parseJson(res);
        res = await handleRes(res);
        return res;
    } catch (e) {
        await Promise.reject({errorMessage: e.message});
    }

}

function getStatus(res) {
    console.log('from api-----------------');
    console.log(res);
    return {isOk: res.ok, status: res.status, res};
}

async function parseJson(res) {
    const resJson = await res.res.json();
    console.log(JSON.stringify(resJson));
    //alert('error???:'+JSON.stringify(resJson))
    if (res.status===400&&resJson.desc==='没有记录') return {isOk: true, data: {data:[]}}
    if (res.status===401) throw {message:unauthorized};
    if (res.status === 500) {
        throw {message: resJson.msg};
    }
    return {isOk: res.isOk, data: resJson};
}

function handleRes(res) {
    if (res.isOk) {
        return res.data;
    }
    throw {message: res.data.desc}
}
