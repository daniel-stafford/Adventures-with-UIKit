//
//  TableViewController.swift
//  Notes
//
//  Created by Daniel Stafford on 1/20/22.
//

import UIKit

class TableViewController: UITableViewController {
    var notes = [Note]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Notes"

        navigationController?.navigationBar.prefersLargeTitles = true

        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        let compose = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(compose))

        toolbarItems = [spacer, compose]
        navigationController?.isToolbarHidden = false

        load()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Note", for: indexPath)
        let note = notes[indexPath.row]
        cell.textLabel?.text = "\(note.body), \(note.createdAt)"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedNote = notes[indexPath.row]
            vc.notes = notes
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            save()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        load()
        tableView.reloadData()
    }

    func load() {
        let defaults = UserDefaults.standard

        if let savedData = defaults.object(forKey: "notes") as? Data {
            let jsonDecoder = JSONDecoder()

            do {
                notes = try jsonDecoder.decode([Note].self, from: savedData)
            } catch {
                print("Failed to load notes")
            }
        }
    }

    func save() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(notes) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "notes")
        } else {
            print("Failed to save notes.")
        }
    }

    @objc func compose() {
        let newNote = Note(body: "")
        notes.append(newNote)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedNote = newNote
            vc.notes = notes
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
