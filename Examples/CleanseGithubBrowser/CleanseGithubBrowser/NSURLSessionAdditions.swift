//
//  NSURLSessionAdditions.swift
//  CleanseGithubBrowser
//
//  Created by Mike Lewis on 6/12/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

import Foundation


extension URLSession {
    func jsonTask(baseURL: URL, pathComponents: String..., resultHandler: @escaping (ErrorOptional<Any>) -> Void) -> URLSessionDataTask {
        let url = baseURL.appendingPathComponent(pathComponents.joined(separator: "/"))
        return jsonTask(url: url as URL, resultHandler: resultHandler)
    }

    private func jsonTask(url: URL, resultHandler: @escaping (ErrorOptional<Any>) -> Void) -> URLSessionDataTask {
        let task = self.dataTask(with: url as URL) { (data, response, error) in
            if let error: Error = error ?? HTTPError(statusCode: (response as! HTTPURLResponse).statusCode) {
                resultHandler(ErrorOptional(error))
                return
            }

            do {
                try resultHandler(ErrorOptional(JSONSerialization.jsonObject(with: data!, options: [])))
            } catch let e {
                resultHandler(ErrorOptional(e))
                return
            }
        }

        task.resume()
        return task
    }

    @discardableResult
    func jsonListTask(
        baseURL: URL,
        pathComponents: String...,
        query: String? = nil,
        resultHandler: @escaping (ErrorOptional<[[String: AnyObject]]>) -> Void
    ) -> URLSessionDataTask {
        var url = baseURL.appendingPathComponent(pathComponents.joined(separator: "/"))

        if let query = query {
            url = URL(string: url.absoluteString + "?" + query)!
        }

        return jsonTask(url: url) { resultHandler($0.map { $0 as! [[String: AnyObject]] }) }
    }
}
