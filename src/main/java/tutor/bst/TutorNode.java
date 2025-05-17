package tutor.bst;

import tutor.model.Tutor;

/**
 * Represents a single node in the Tutor Binary Search Tree (BST).
 * Each node stores a Tutor object and references to its left and right child nodes.
 */
public class TutorNode {

    // The Tutor object stored in this node
    public Tutor data;

    // Left and right child nodes
    public TutorNode left, right;

    /**
     * Constructor to initialize the node with a Tutor object.
     * Child references are set to null by default.
     *
     * @param data the Tutor to store in this node
     */
    public TutorNode(Tutor data) {
        this.data = data;
        this.left = null;
        this.right = null;
    }
}
