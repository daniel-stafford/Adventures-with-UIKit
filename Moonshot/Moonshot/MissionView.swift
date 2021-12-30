//
//  MissionView.swift
//  Moonshot
//
//  Created by Daniel Stafford on 12/27/21.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Image(mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width * 0.6)
                        .padding(.top)

                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)

                        Text(mission.description)
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom)
            }
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .background(.darkBackground)
    }
}

struct MissionView_Previews: PreviewProvider {
    static var mission: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        MissionView(mission: mission[0])
            .preferredColorScheme(.dark)
    }
}
