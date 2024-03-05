import { create } from 'zustand'
import { getData } from './getApi'


export interface DataTree {
    src: TableNode[],
    dest: TableNode[]
};

export interface TableNode {
    name: string,
    columns: string[]
};

interface TreeNodeStore {
    dataTree: DataTree,
    updateDestNode: (newTable: string, columnsList: string[]) => void;
    fetchTreeNode: () => void
};

export const useTreeNodeStore = create<TreeNodeStore>((set) => ({
    dataTree: { src: [], dest: [] },
    updateDestNode: (newTable: string, columnsList: string[]) =>
        set((state) => ({
            dataTree: {
                ...state.dataTree,
                dest: [...state.dataTree.dest, { name: newTable, columns: columnsList }],
            },
        })),
    fetchTreeNode: async () => {
        const fetchTreeNode = await getData('all_table_column')
        set({ dataTree: fetchTreeNode })
    }
}))