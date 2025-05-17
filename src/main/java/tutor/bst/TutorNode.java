package tutor.bst;

import tutor.model.Tutor;

public class TutorNode {
    public Tutor data;
    public TutorNode left, right;

    public TutorNode(Tutor data) {
        this.data = data;
        this.left = null;
        this.right = null;
    }
}