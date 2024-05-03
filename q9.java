package swingj;

import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.GridLayout;
import javax.swing.BorderFactory;
import javax.swing.BoxLayout;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JRadioButton;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.JTextField;
import javax.swing.border.TitledBorder;
import javax.swing.event.ListSelectionEvent;
import javax.swing.event.ListSelectionListener;
import javax.swing.table.DefaultTableModel;

public class q9 extends JFrame {
	JPanel frompan = new JPanel();

	JLabel id, name, gender, addresess, conctect;
	JTextField idf, namef, gendef, addf, concf;
	JRadioButton male, female;
	ButtonGroup bg;
	JButton exit, resigter, delate, update, reset, refresh;

	String[] column = { "S.No.", "ID", "Name", "Gender", "Address", "Contact" };
	String[][] data = {};

	DefaultTableModel model;
	JTable table;
	int Row = 1;
	int selectedModelIndex = -1;

	public q9() {

		setSize(800, 500);
		setLocationRelativeTo(null);

		frompan.setLayout(new BoxLayout(frompan, BoxLayout.Y_AXIS));
		frompan.setBorder(new TitledBorder(BorderFactory.createEtchedBorder(), "Registration Detail",
				TitledBorder.CENTER, TitledBorder.TOP));

		JPanel pan = new JPanel(new GridLayout(5, 2, 5, 5));
		pan.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
		id = new JLabel("id");
		name = new JLabel("name");
		gender = new JLabel("Gender");
		addresess = new JLabel("addrees");
		conctect = new JLabel("contect");

		idf = new JTextField(10);
		namef = new JTextField(10);
		gendef = new JTextField(10);
		addf = new JTextField(10);
		concf = new JTextField(10);

		JPanel redipan = new JPanel(new FlowLayout(FlowLayout.LEFT));
		male = new JRadioButton("Male", true);
		female = new JRadioButton("female");
		bg = new ButtonGroup();
		bg.add(female);
		bg.add(male);
		redipan.add(male);
		redipan.add(female);

		pan.add(id);
		pan.add(idf);
		pan.add(name);
		pan.add(namef);
		pan.add(gender);
		pan.add(redipan);
		pan.add(addresess);
		pan.add(addf);
		pan.add(conctect);
		pan.add(concf);

		JPanel buttongrid = new JPanel(new GridLayout(2, 2, 5, 5));
		exit = new JButton("Exit");
		resigter = new JButton("Resigter");
		delate = new JButton("Delete");
		update = new JButton("Update");

		buttongrid.add(exit);
		buttongrid.add(resigter);
		buttongrid.add(delate);
		buttongrid.add(update);
		delate.setEnabled(false);
		update.setEnabled(false);
		JPanel resetbut = new JPanel(new FlowLayout(FlowLayout.CENTER));
		reset = new JButton("Reset");
		resetbut.add(reset);

		JPanel buttonpan = new JPanel(new BorderLayout());
		buttonpan.setBorder(BorderFactory.createEmptyBorder(10, 10, 10, 10));
		buttonpan.add(buttongrid, BorderLayout.NORTH);
		buttonpan.add(resetbut, BorderLayout.CENTER);

		JPanel west = new JPanel(new BorderLayout());
		west.add(frompan, BorderLayout.NORTH);
		west.add(buttonpan, BorderLayout.SOUTH);

		JPanel tablePanel = new JPanel(new BorderLayout());
		model = new DefaultTableModel(column, 0);
		table = new JTable(model);
		table.setRowHeight(30);
		JScrollPane scrollPane = new JScrollPane(table);

		JPanel refreshButtonPanel = new JPanel(new FlowLayout(FlowLayout.CENTER));
		add(west, BorderLayout.WEST);

		refresh = new JButton("Refresh Table");
		refreshButtonPanel.add(refresh);

		tablePanel.add(scrollPane, BorderLayout.CENTER);
		tablePanel.add(refresh, BorderLayout.SOUTH);

		add(tablePanel, BorderLayout.CENTER);
		setVisible(true);
		frompan.add(pan);
		exit.addActionListener(e -> exit());
		resigter.addActionListener(e -> register());
		update.addActionListener(e -> update());
		refresh.addActionListener(e -> refresh());
		delate.addActionListener(e -> delate());
		reset.addActionListener(e -> reset());

		table.getSelectionModel().addListSelectionListener(new ListSelectionListener() {

			@Override
			public void valueChanged(ListSelectionEvent e) {

				int viewRow = table.getSelectedRow();

				if (viewRow != -1) {

					selectedModelIndex = table.convertRowIndexToModel(viewRow);

					idf.setText(model.getValueAt(selectedModelIndex, 1).toString());
					namef.setText(model.getValueAt(selectedModelIndex, 2).toString());
					addf.setText(model.getValueAt(selectedModelIndex, 4).toString());
					concf.setText(model.getValueAt(selectedModelIndex, 5).toString());

					String gender = model.getValueAt(selectedModelIndex, 3).toString();

					if (gender.equals("Male")) {
						male.setSelected(true);
					} else {
						female.setSelected(true);
					}

					delate.setEnabled(true);
					update.setEnabled(true);

				} else {
					clearFields();
				}

			}
		});

	}

	public void reset() {
		idf.setText("");
		namef.setText("");
		addf.setText("");
		concf.setText("");
		male.setSelected(true);
		delate.setEnabled(false);
		update.setEnabled(false);
		
	}

	protected void clearFields() {
		idf.setText("");
		namef.setText("");
		addf.setText("");
		concf.setText("");
		male.setSelected(true);
		delate.setEnabled(false);
		update.setEnabled(false);

	}

	public void delate() {
		int Rows = table.getSelectedRow();
		model.removeRow(Rows);
		JOptionPane.showMessageDialog(q9.this, "deleted !1");
	}

	public void exit() {
		System.exit(0);

	}

	public void refresh() {
		model.setRowCount(0);

	}

	public void update() {

	}

	public void register() {

		String id = idf.getText();
		String name = namef.getText();
		String gender = male.isSelected() ? "male" : "female";
		String address = addf.getText();
		String contect = concf.getText();

		model.addRow(new Object[] { Row, id, name, gender, address, contect });
		Row++;

		idf.setText("");
		namef.setText("");
		gendef.setText("");
		addf.setText("");
		concf.setText("");
		idf.setText("");
	}

	public static void main(String[] args) {
		new q9();

	}

}
