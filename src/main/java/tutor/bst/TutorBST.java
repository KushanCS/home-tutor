package tutor.bst;

import tutor.model.Tutor;

/**
 * A singleton Binary Search Tree (BST) class to manage Tutor objects.
 * Tutors are organized in the tree based on their usernames (lexicographical order).
 */
public class TutorBST {
    private TutorNode root; // Root of the BST
    private static TutorBST instance; // Singleton instance

    // ===== Singleton Getter =====
    public static TutorBST getInstance() {
        if (instance == null) {
            instance = new TutorBST();
        }
        return instance;
    }

    // ===== Insert Tutor into BST =====
    public void insert(Tutor tutor) {
        root = insertRec(root, tutor);
    }

    private TutorNode insertRec(TutorNode node, Tutor tutor) {
        if (node == null) return new TutorNode(tutor);

        int cmp = tutor.getUsername().compareToIgnoreCase(node.data.getUsername());
        if (cmp < 0) node.left = insertRec(node.left, tutor);
        else if (cmp > 0) node.right = insertRec(node.right, tutor);
        // If usernames are equal, ignore insertion to avoid duplicates
        return node;
    }

    // ===== Search by Username (exact match) =====
    public Tutor search(String username) {
        return searchRec(root, username);
    }

    private Tutor searchRec(TutorNode node, String username) {
        if (node == null) return null;

        int cmp = username.compareToIgnoreCase(node.data.getUsername());
        if (cmp == 0) return node.data;
        else if (cmp < 0) return searchRec(node.left, username);
        else return searchRec(node.right, username);
    }

    // ===== Search by Username OR Tutor ID =====
    public Tutor searchByUsernameOrId(String input) {
        return searchRecursive(root, input);
    }

    private Tutor searchRecursive(TutorNode node, String input) {
        if (node == null) return null;

        if (node.data.getUsername().equalsIgnoreCase(input) ||
                node.data.getTutorId().equalsIgnoreCase(input)) {
            return node.data;
        }

        Tutor left = searchRecursive(node.left, input);
        return (left != null) ? left : searchRecursive(node.right, input);
    }

    // ===== Search by Email (case-insensitive) =====
    public Tutor searchByEmail(String email) {
        return searchByEmailRecursive(root, email);
    }

    private Tutor searchByEmailRecursive(TutorNode node, String email) {
        if (node == null) return null;

        if (node.data.getEmail().equalsIgnoreCase(email)) {
            return node.data;
        }

        Tutor leftResult = searchByEmailRecursive(node.left, email);
        if (leftResult != null) return leftResult;

        return searchByEmailRecursive(node.right, email);
    }
}
