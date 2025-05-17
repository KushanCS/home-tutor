package tutor.bst;

import tutor.model.Tutor;

/**
 * This class implements a Binary Search Tree (BST) for managing Tutor objects.
 * It supports insertion and search operations by username, tutor ID, or email.
 */
public class TutorBST {

    // The root node of the BST
    private TutorNode root;

    // Singleton instance of TutorBST
    private static TutorBST instance;

    /**
     * Inserts a tutor into the BST.
     *
     * @param tutor the Tutor object to insert
     */
    public void insert(Tutor tutor) {
        root = insertRec(root, tutor);
    }

    // Recursive method to insert a tutor based on username
    private TutorNode insertRec(TutorNode node, Tutor tutor) {
        if (node == null) return new TutorNode(tutor);  // Create new node if tree/subtree is empty

        int cmp = tutor.getUsername().compareToIgnoreCase(node.data.getUsername());

        if (cmp < 0) {
            node.left = insertRec(node.left, tutor);   // Go left if username is less
        } else if (cmp > 0) {
            node.right = insertRec(node.right, tutor); // Go right if username is greater
        }
        // If username is equal, do nothing (no duplicates allowed)
        return node;
    }

    /**
     * Searches the BST for a tutor by username.
     *
     * @param username the username to search for
     * @return the Tutor if found, or null
     */
    public Tutor search(String username) {
        return searchRec(root, username);
    }

    // Recursive search by username
    private Tutor searchRec(TutorNode node, String username) {
        if (node == null) return null;

        int cmp = username.compareToIgnoreCase(node.data.getUsername());

        if (cmp == 0) return node.data;             // Match found
        else if (cmp < 0) return searchRec(node.left, username);   // Search left
        else return searchRec(node.right, username);               // Search right
    }

    /**
     * Searches the entire tree for a tutor by username or tutor ID.
     * This is a full traversal and does not use BST properties.
     *
     * @param input username or tutor ID
     * @return the Tutor if found, or null
     */
    public Tutor searchByUsernameOrId(String input) {
        return searchRecursive(root, input);
    }

    // Recursive method to search by username or tutor ID
    private Tutor searchRecursive(TutorNode node, String input) {
        if (node == null) return null;

        if (node.data.getUsername().equalsIgnoreCase(input) ||
                node.data.getTutorId().equalsIgnoreCase(input)) {
            return node.data;
        }

        // Search left, then right
        Tutor left = searchRecursive(node.left, input);
        return (left != null) ? left : searchRecursive(node.right, input);
    }

    /**
     * Searches the tree for a tutor by email address.
     *
     * @param email the email to search for
     * @return the Tutor if found, or null
     */
    public Tutor searchByEmail(String email) {
        return searchByEmailRecursive(root, email);
    }

    // Recursive email search
    private Tutor searchByEmailRecursive(TutorNode node, String email) {
        if (node == null) return null;

        if (node.data.getEmail().equalsIgnoreCase(email)) {
            return node.data;
        }

        Tutor leftResult = searchByEmailRecursive(node.left, email);
        if (leftResult != null) return leftResult;

        return searchByEmailRecursive(node.right, email);
    }

    /**
     * Singleton pattern to ensure only one instance of TutorBST is used.
     *
     * @return the singleton instance of TutorBST
     */
    public static TutorBST getInstance() {
        if (instance == null) {
            instance = new TutorBST();
        }
        return instance;
    }
}
