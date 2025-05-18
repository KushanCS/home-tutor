package tutor.bst;

import tutor.model.Tutor;

/**
 * Node class used in the TutorBST.
 * Each node stores a Tutor object and references to left and right child nodes.
 */
public class TutorNode {

    // === Data Fields ===
    public Tutor data;        // The Tutor object stored in this node
    public TutorNode left;    // Reference to left child (smaller usernames)
    public TutorNode right;   // Reference to right child (larger usernames)

    // === Constructor ===
    public TutorNode(Tutor data) {
        this.data = data;
        this.left = null;
        this.right = null;
    }
}
