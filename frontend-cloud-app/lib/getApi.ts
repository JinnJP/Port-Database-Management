const DOMAIN = 'http://localhost:4999/'

export async function postData(path: string, params: any) {
    const url = DOMAIN + path
    const options = {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            // You may need to add additional headers depending on your server requirements
        },
        body: JSON.stringify(params),
    };
    const res = await fetch(url, options)
    if (!res.ok) throw new Error('Failed to fetch data')
    const data = await res.json()
    return data
}

export async function getData(path: string) {
    const url = DOMAIN + path
    const options = {
        method: 'GET',
        headers: {
            'Content-Type': 'application/json',
            // You may need to add additional headers depending on your server requirements
        },
    };
    const res = await fetch(url, options)
    if (!res.ok) throw new Error('Failed to fetch data')
    const data = await res.json()
    return data
}
