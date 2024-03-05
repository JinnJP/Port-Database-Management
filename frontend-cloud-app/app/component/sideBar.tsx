'use client'

import { DataTree, useTreeNodeStore } from "@/lib/store";

import { useEffect, useState } from "react";
import { Tree } from "primereact/tree";
import { NodeService } from "../service/NodeService";

export default function TreeComponent({ }) {
    const [nodes, setNodes] = useState<any[]>([]);
    const dataTreeNode = useTreeNodeStore();

    useEffect(() => {
        if (dataTreeNode.dataTree.src.length === 0) {
            dataTreeNode.fetchTreeNode();
        }
        // dataTree after fetch
        initTreeNode(dataTreeNode.dataTree);
    }, [dataTreeNode]);

    const initTreeNode = (dataTree: DataTree) => {
        // crete tree node by dataTree
        NodeService.getTreeNodes(dataTree).then((data) => setNodes(data));
    };
 
    return (
        <Tree value={nodes} filter filterMode="strict" filterPlaceholder="Search" className="w-64 min-h-full h-fit" />
    );
}