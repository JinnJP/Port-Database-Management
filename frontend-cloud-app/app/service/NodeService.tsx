import { DataTree, TableNode } from "@/lib/store";

export const NodeService = {
    getTreeNodesDatacolum(dataTree: DataTree) {
        const treeNodes = [];
        // เพิ่มโหนดสำหรับ source
        treeNodes.push({
            key: 'source',
            label: 'Src',
            icon: 'pi pi-database',
            children: dataTree.src.flatMap((item: TableNode, index: number) => [
                {
                    key: `source-${index}`,
                    label: item.name,
                    icon: 'pi pi-table',
                    children: item.columns.map((column, i) => ({
                        key: `source-${index}-${i}`,
                        label: column,
                        icon: 'pi pi-file',
                        datacolum: column
                    }))
                }
            ])
        });
        // เพิ่มโหนดสำหรับ destination
        treeNodes.push({
            key: 'destination',
            label: 'Dest',
            icon: 'pi pi-database',
            children: dataTree.dest.flatMap((item: TableNode, index: number) => [
                {
                    key: `destination-${index}`,
                    label: item.name,
                    icon: 'pi pi-table',
                    children: item.columns.map((column, i) => ({
                        key: `destination-${index}-${i}`,
                        label: column,
                        icon: 'pi pi-file',
                        datacolum: column
                    }))
                }
            ])
        });

        return treeNodes;
    },

    getTreeNodes(dataTree: DataTree) {
        return Promise.resolve(this.getTreeNodesDatacolum(dataTree));
    }
};