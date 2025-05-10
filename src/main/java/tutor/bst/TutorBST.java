package tutor.bst;

import tutor.model.Tutor;

public class TutorBST {
    private TutorNode root;

    public void insert(Tutor tutor) {
        root = insertRec(root, tutor);
    }

    private TutorNode insertRec(TutorNode node, Tutor tutor) {
        if (node == null) return new TutorNode(tutor);
        int cmp = tutor.getUsername().compareToIgnoreCase(node.data.getUsername());
        if (cmp < 0) node.left = insertRec(node.left, tutor);
        else if (cmp > 0) node.right = insertRec(node.right, tutor);
        return node;
    }

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

    // 🔍 Search by Username or Tutor ID
    public Tutor searchByUsernameOrId(String input) {
        return searchRecursive(root, input);
    }

    private Tutor searchRecursive(TutorNode node, String input) {
        if (node == null) return null;
        if (node.data.getUsername().equalsIgnoreCase(input) || node.data.getTutorId().equalsIgnoreCase(input)) {
            return node.data;
        }
        Tutor left = searchRecursive(node.left, input);
        return (left != null) ? left : searchRecursive(node.right, input);
    }
}
