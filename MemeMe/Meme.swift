//
//  Meme.swift
//  MemeMe
//
//  Created by Mate Salekovics on 21/05/15.
//  Copyright (c) 2015 Mate Salekovics. All rights reserved.
//

import UIKit

class Meme {
    // text for top of the Meme
    var top = ""
    // text for bottom of the Meme
    var bottom = ""
    // background image for the Meme
    var image = UIImage()
    // text and image composed for sharing
    var memeImage = UIImage()
    
     //setting member variables using constructor function
       init(top: String, bottom: String, image: UIImage, memeImage: UIImage) {
        self.top = top
        self.bottom = bottom
        self.image = image
        self.memeImage = memeImage
    }
    //save the Meme
     func save() {
        Meme.getStorage().memes.append(self)
    }
    // get the memes
    class func getStorage() -> AppDelegate {
        let object = UIApplication.sharedApplication().delegate
        return object as! AppDelegate
    }
    // return all memes
    class func findAll() -> [Meme] {
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        return Meme.getStorage().memes
    }
    // count memes
    class func countAll() -> Int {
        return Meme.getStorage().memes.count
    }
    // get meme from index
      class func getAtIndex(index: Int) -> Meme? {
        if Meme.getStorage().memes.count > index {
            return Meme.getStorage().memes[index]
        }
        return nil
    }
    // remove meme from index
     class func removeAtIndex(index: Int) {
        if index >= 0 && Meme.getStorage().memes.count > index {
            Meme.getStorage().memes.removeAtIndex(index)
        }
    }
}
