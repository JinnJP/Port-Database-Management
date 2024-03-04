import { create } from 'zustand'
import { getData } from './getApi'


export interface DataTree {
    source: TableNode[],
    dest: TableNode[]
};

export interface TableNode {
    name: string,
    columns: string[]
};

interface TreeNodeStore {
    dataTree: DataTree,
    fetchTreeNode: () => void
};

export const useTreeNodeStore = create<TreeNodeStore>((set) => ({
    dataTree: { source: [], dest: [] },
    fetchTreeNode: async () => {
        const fetchTreeNode = await getData('all_table_column')
        set({ dataTree: fetchTreeNode })
    }
}))