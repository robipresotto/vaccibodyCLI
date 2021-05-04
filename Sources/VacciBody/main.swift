//
//  main.swift
//  VacciBody
//
//  Created by Robinson Presotto on 30/04/2021.
//


import ArgumentParser
import VacciBodyLib

struct VacciBody: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "vaccibody",
    abstract: "VacciBody CLI",
    subcommands: [
      PeptidesMatcher.self
    ]
  )
  
  init() {}
  
}

VacciBody.main()
