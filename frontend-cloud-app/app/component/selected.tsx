'use client'

import { TableNode, useTreeNodeStore } from '@/lib/store';
import { postData } from '@/lib/getApi';

import { useEffect, useState } from 'react';
import { Button } from 'primereact/button';
import { Card } from 'primereact/card';
import { MultiSelect } from 'primereact/multiselect';
import { DataTable } from 'primereact/datatable';
import { Column } from 'primereact/column';
import { Dropdown } from 'primereact/dropdown';
import { Dialog } from 'primereact/dialog';
import { InputText } from 'primereact/inputtext';

export default function Selected({ }) {
    type Title = 'Failed!' | 'Error!' | 'Success!'
    type Color = 'red' | 'red' | 'green'

    const colorAlert: Record<Title, Color> = {
        'Failed!': 'red',
        'Error!': 'red',
        'Success!': 'green'
    };
    const dataTreeNode = useTreeNodeStore();

    const [visible, setVisible] = useState<boolean>(false);
    const [textDialog, setTextDialog] = useState<{ title: Title, text: string }>({ title: 'Success!', text: 'test' });
    // title new table
    const [newTableName, setNewTableName] = useState<string>('');
    // edit column table
    const [showEditModal, setShowEditModal] = useState(false);
    const [newColumn, setNewColumn] = useState("");
    const [editIndex, setEditIndex] = useState(-1);
    const [newTableColumns, setNewTableColumns] = useState<string[]>([]);

    // data table
    const [nodeTablesSource, setNodeTablesSource] = useState<TableNode[]>();
    // option table
    const [tablesOption, setTablesOption] = useState<string[]>(['']);
    const [selectedTables, setSelectedTables] = useState<string | undefined>();

    const [columnsOption, setColumnsOption] = useState<string[]>(['']);
    const [selectedColumns, setSelectedColumns] = useState<string[]>([]);

    const [dataTable, setDataTable] = useState<any[]>([]);

    useEffect(() => {
        if (dataTreeNode.dataTree.source.length === 0) {
            dataTreeNode.fetchTreeNode();
        }
        // get data from store
        const dataTree = dataTreeNode.dataTree
        // set table source to use in create
        setNodeTablesSource(dataTree.source)

        setAllTableSource(dataTree.source)
    }, [dataTreeNode]);

    const setAllTableSource = (dataSource: TableNode[]) => {
        // set table list to select
        const tableList = dataSource.map((table: TableNode) => {
            return table.name
        })
        setTablesOption(tableList)
    }

    const setColumnByTable = (selectedTable: string) => {
        // set table that selected
        setSelectedTables(selectedTable)
        setNewTableName(selectedTable)
        // set column
        const columnList = getColumnByselectedTable(nodeTablesSource || [], selectedTable)
        // set option column
        setColumnsOption(columnList)
        // set column selected default is all
        setSelectedColumns(columnList)
        // new table column is selectedColumn
        setNewTableColumns(columnList)
        // load table
        loadTable(selectedTable)
    }

    const getColumnByselectedTable = (dataSource: TableNode[], selectTable: string) => {
        let columnList: string[] = []
        for (let index = 0; index < dataSource?.length; index++) {
            if (selectTable === dataSource[index].name) {
                // find selected table in data source
                columnList = columnList.concat(dataSource[index].columns)
            }
        };
        return columnList
    }

    const setAllColumn = (columns: string[]) => {
        // set selected column
        setSelectedColumns(columns)
        // reset edit column
        setNewTableColumns(columns)
    }

    const createTable = async (sourceTableName: string | undefined, selectedColumnsName: string[] | undefined, destTableName: string, columnsName: string[]) => {
        // check input
        if (!sourceTableName || !destTableName || !selectedColumnsName || selectedColumnsName.length === 0) {
            setTextDialog({ title: 'Failed!', text: 'Please, Check your input or selected!' })
            return setVisible(true)
        }

        const path = 'create_table';
        const params = {
            sourceTable: sourceTableName,
            sourceColumn: selectedColumnsName,
            destTable: destTableName,
            destColumn: columnsName
        };

        try {
            const data = await postData(path, params);
            if (data.status) {
                setTextDialog({ title: 'Success!', text: data.status });
                // update dest in side bar
                dataTreeNode.updateDestNode(destTableName, columnsName);
            } else {
                setTextDialog({ title: 'Failed!', text: data.error });
            }
            return setVisible(true)
        } catch (error: any) {
            console.error('Error:', error.message);
        }
    }

    const loadTable = async (tableName: string | undefined) => {
        if (!tableName) {
            return
        }
        // fetch api load table
        const path = 'select_table';
        const params = {
            table: tableName
        };

        try {
            const data = await postData(path, params);
            setDataTable(data)
        } catch (error: any) {
            // if error or no data
            console.error('Error:', error.message);
            setDataTable([])
        }
    };

    const handleChangeColumnName = () => {
        const newColumnHeaders = [...newTableColumns || []];
        newColumnHeaders[editIndex] = newColumn;
        setNewTableColumns(newColumnHeaders);
        setShowEditModal(false);
    };

    return (
        <div>
            <Dialog header={textDialog?.title} visible={visible} headerStyle={{ color: `${colorAlert[textDialog?.title]}` }} style={{ width: 'fit-content' }} onHide={() => setVisible(false)}>
                <p className="m-0 px-5">
                    {textDialog?.text}
                </p>
            </Dialog>
            <Card>
                <div className="grid grid-cols-2 gap-3">
                    <div>
                        <label className="flex items-center font-semibold">Source Table</label>
                        <Dropdown showClear value={selectedTables} filter onChange={(e) => setColumnByTable(e.value)}
                            options={tablesOption} placeholder="Select Table"
                            className='w-full my-3' />
                    </div>
                    <div>
                        <label className="flex items-center font-semibold">Column</label>
                        <MultiSelect value={selectedColumns} filter onChange={(e) => setAllColumn(e.value)}
                            options={columnsOption} placeholder="Select Column"
                            className='w-full my-3' />
                    </div>
                </div>
            </Card>
            <div className="grid gap-4 w-full h-fit mt-10">
                <div className='flex flex-row'>
                    <label className="flex items-center font-semibold mr-5">Table name:</label>
                    <InputText value={newTableName} onChange={(e) => setNewTableName(e.target.value)} />
                </div>
                <label className="text-slate-500 text-sm">*Example data limit 5 record</label>
                <DataTable value={dataTable} showGridlines scrollable scrollHeight="400px" size='small' tableStyle={{ minWidth: '100%' }}>
                    {selectedColumns?.map((column: any, index: number) => {
                        return <Column key={index} field={column} header={
                            <div>
                                {newTableColumns[index]}
                                <i className="pi pi-pencil ml-2 cursor-pointer" onClick={() => {
                                    setShowEditModal(true);
                                    setEditIndex(index);
                                    setNewColumn(column);
                                }}></i>
                            </div>
                        }></Column>
                    })}
                </DataTable>
                <Dialog header='Edit Column' visible={showEditModal} onHide={() => setShowEditModal(false)} className="bg-white rounded-lg overflow-hidden shadow-xl w-1/3 p-6">
                    <div className="flex flex-col items-center justify-center">
                        <input type="text" value={newColumn} onChange={(e) => setNewColumn(e.target.value)} className="w-full mb-4 border border-gray-300 rounded-md px-3 py-2 focus:outline-none focus:border-blue-500" />
                        <Button label="Save" className="w-full bg-blue-500 text-white py-2 px-4 rounded-md hover:bg-blue-600 transition duration-200" onClick={handleChangeColumnName} />
                    </div>
                </Dialog>
                <div className='flex flex-col'>
                    <label className="text-slate-500 text-sm">Create table to destination database</label>
                    <Button className="mt-4" label="Create Table" onClick={() => createTable(selectedTables, selectedColumns, newTableName, newTableColumns)} />
                </div>
            </div>
        </div>
    );
}