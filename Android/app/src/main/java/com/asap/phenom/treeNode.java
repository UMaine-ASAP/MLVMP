package com.asap.phenom;



import java.util.ArrayList;

/**
 * Created by mikescott on 6/2/15.
 */
public class treeNode
{
    private treeNode parent;
    private String nodeName;
    private ArrayList<treeNode> children;
    private String photo;

    public treeNode(treeNode parent, String nodeName, ArrayList<treeNode> children, String photo)
    {
        this.parent = parent;
        this.nodeName = nodeName;
        this.children = children;
        this.photo = photo;
    }
    public void removeChildren(ArrayList<treeNode> children)
    {
        this.children.removeAll(children);
    }

    public treeNode getParent()                                     //Returns parent node
    {
        return parent;
    }

    public String getNodeName()                                     //Returns node name
    {
        return nodeName;
    }

    public ArrayList<treeNode> getChildren()                        //Returns arrayList of children
    {
        return children;
    }
    public void setChildren(ArrayList<treeNode> children)           //Sets children to passed arraylist
    {
        this.children = children;
    }
    public String getPhoto()                                        //Returns photo file name associated with node
    {
        return photo;
    }
    public treeNode getChild(String name)                           //Returns child node with passed name (null if not found)
    {
        treeNode child = null;
        for (treeNode c : this.getChildren())
            if (name.equals(c.getNodeName()))
                child = c;
        return child;
    }
    public boolean isLeaf()                                         //Returns whether or not this node is leaf (if it has no children)
    {
        return (children == null);
    }

}
