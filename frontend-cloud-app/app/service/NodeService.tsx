export const NodeService = {
    getTreeNodesDatacolum(dataTree: any) {
        const treeNodes = [];

        // เพิ่มโหนดสำหรับ source
        treeNodes.push({
            key: 'source',
            label: 'Src',
            icon: 'pi pi-database',
            children: dataTree.source.flatMap((item: { name: any; columns: any[]; }, index: any) => [
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
            children: dataTree.dest.flatMap((item: { name: any; columns: any[]; }, index: any) => [
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

    getTreeNodes(dataTree: any) {
        return Promise.resolve(this.getTreeNodesDatacolum(dataTree));
    }
};
