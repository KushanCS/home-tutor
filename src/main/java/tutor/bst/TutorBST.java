package tutor.bst;

import tutor.model.Tutor;
import java.util.ArrayList;
import java.util.List;

public class TutorBST {
    private TutorNode root;
    private static TutorBST instance;

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

    public static TutorBST getInstance() {
        if (instance == null) {
            instance = new TutorBST();
        }
        return instance;
    }
    public List<Tutor> getAllTutors() {
        List<Tutor> tutorList = new ArrayList<>();
        inOrderTraversal(root, tutorList);
        return tutorList;
    }

    private void inOrderTraversal(TutorNode node, List<Tutor> list) {
        if (node == null) return;
        inOrderTraversal(node.left, list);
        list.add(node.data); // 'data' holds the Tutor object
        inOrderTraversal(node.right, list);
    }
}
