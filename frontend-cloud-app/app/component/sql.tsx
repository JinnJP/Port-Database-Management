'use client'

import { postData } from "@/lib/getApi";

import { Button } from "primereact/button";
import { InputTextarea } from "primereact/inputtextarea";
import { useState } from "react";

export default function Sql() {
    const [value, setValue] = useState('');
    const [outputData, setOutputData] = useState('');

    const excecuteSql = async (textSql: string) => {
        if (!textSql) {
            return
        }
        // fetch api load table
        const path = 'manual_sql';
        const params = {
            sql: textSql
        };
        try {
            const data = await postData(path, params);
            if (data.error) {
                setOutputData(data.error)
            } else {
                setOutputData(JSON.stringify(data))
            }
        } catch (error: any) {
            console.error('Error:', error.message);
        }
    };

    return (
        <div>
            <label className="text-slate-500 text-sm">SQL version 5.7 :</label>
            <div className="card flex justify-content-center">
                <InputTextarea value={value} onChange={(e) => setValue(e.target.value)} rows={5} cols={100} />
            </div>
            <Button className="my-4" label="Submit" onClick={() => excecuteSql(value)} />
            <br/>
            <label className="text-slate-500 text-sm">Output :</label>
            <div className="card flex justify-content-center">
                <InputTextarea disabled value={outputData} rows={5} cols={100} />
            </div>
        </div>
    );
}