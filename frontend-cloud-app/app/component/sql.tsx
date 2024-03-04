'use client'

import { postData } from "@/lib/getApi";

import { useState } from "react";
import { Button } from "primereact/button";
import { InputTextarea } from "primereact/inputtextarea";

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
                setOutputData(JSON.stringify(data, null, 4))
            }
        } catch (error: any) {
            console.error('Error:', error.message);
        }
    };

    return (
        <div className="flex flex-col">
            <label className="text-slate-500 text-sm">SQL version 5.7 :</label>
            <div className="card flex justify-content-center">
                <InputTextarea value={value} onChange={(e) => setValue(e.target.value)} rows={5} cols={100} />
            </div>
            <div>
                <Button className="my-4 mr-20 w-fit" label="Submit" onClick={() => excecuteSql(value)} />
            </div>
            <label className="text-slate-500 text-sm">Output :</label>
            <div className="card flex justify-content-center">
                <div className="border-[1px] rounded border-[#d1d5db] min-h-fit h-40 max-w-[1040px] p-4 overflow-auto">{outputData}</div>
            </div>
        </div>
    );
}