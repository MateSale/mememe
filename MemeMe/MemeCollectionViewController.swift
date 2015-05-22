//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Mate Salekovics on 21/05/15.
//  Copyright (c) 2015 Mate Salekovics. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var selectedIndex: Int?
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // show editor if there are aren't any memes
        if Meme.countAll() == 0 {
            performSegueWithIdentifier("showEditor", sender: self)
        }
        collectionView!.reloadData()
        // display button if there aren't any memes after deletion
        navigationItem.leftBarButtonItem?.enabled = Meme.countAll() > 0
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        collectionView!.reloadData()
    }
 
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("memeCollectionCell", forIndexPath: indexPath) as! MemeCollectionViewCell
        if let meme = Meme.getAtIndex(indexPath.row) {
            cell.memeImageView.image = meme.memeImage
        }
        cell.deleteButton.hidden = !editing
        cell.deleteButton.addTarget(self, action: "didPressDelete:", forControlEvents: .TouchUpInside)
        return cell
    }
    
    @IBAction func didPressDelete(sender: UIButton) {
        // from button to cell
        let cell = sender.superview!.superview! as! MemeCollectionViewCell
        let index = collectionView!.indexPathForCell(cell)!
        Meme.removeAtIndex(index.row)
        collectionView!.deleteItemsAtIndexPaths([index]);
        setEditing(false, animated: true)
        navigationItem.leftBarButtonItem?.enabled = Meme.countAll() > 0
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Meme.countAll()
    }
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        selectedIndex = indexPath.row
        if !editing {
            performSegueWithIdentifier("showDetail", sender: self)
        }
    }
   
    @IBAction func didPressAdd(sender: AnyObject) {
        performSegueWithIdentifier("showEditor", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            var destination = segue.destinationViewController as! DetailViewController
            if let meme = Meme.getAtIndex(selectedIndex!) {
                destination.meme = meme
            }
        }
    }
}