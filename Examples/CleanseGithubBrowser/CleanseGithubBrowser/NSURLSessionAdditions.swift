//
//  NSURLSessionAdditions.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


extension NSURLSession {

    func jsonTask(baseURL baseURL: NSURL, pathComponents: String..., resultHandler: ErrorOptional<AnyObject> -> ()) -> NSURLSessionDataTask {

        let url = baseURL.URLByAppendingPathComponent(pathComponents.joined(separator: "/"))

        return jsonTask(url: url!, resultHandler: resultHandler)
    }

    private func jsonTask(url url: NSURL, resultHandler: ErrorOptional<AnyObject> -> ()) -> NSURLSessionDataTask {

        let task = self.dataTaskWithURL(url) { (data, response, error) in
            if let error: ErrorType = error ?? HTTPError(statusCode: (response as! NSHTTPURLResponse).statusCode) {
                resultHandler(.init(error))
                return
            }

            do {
                try resultHandler(.init(NSJSONSerialization.JSONObjectWithData(data!, options: [])))
            } catch let e {
                resultHandler(.init(e))
                return
            }
        }

        task.resume()

        return task
    }

    func jsonListTask(
        baseURL baseURL: NSURL,
        pathComponents: String...,
        query: String? = nil,
        resultHandler: ErrorOptional<[[String: AnyObject]]> -> ()
    ) -> NSURLSessionDataTask {
        var url = baseURL.URLByAppendingPathComponent(pathComponents.joined(separator: "/"))

        if let query = query {
            url = NSURL(string: url!.absoluteString! + "?" + query)!
        }

        return jsonTask(url: url!) { resultHandler($0.map { $0 as! [[String: AnyObject]] }) }
    }
}
