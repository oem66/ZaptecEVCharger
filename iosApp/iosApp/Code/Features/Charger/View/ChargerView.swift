import SwiftUI
import shared

struct ChargerView: View {
    @Binding var navigationPath: NavigationPath
    @StateObject private var viewModel = ChargerViewModel()
    @State private var showingAllChargers = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color(hex: "0A0E27"),
                    Color(hex: "1A1F3A")
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if viewModel.isLoading {
                    LoadingView()
                } else if let charger = viewModel.charger {
                    ScrollView {
                        VStack(spacing: 20) {
                            ChargerCardView(
                                navigationPath: $navigationPath,
                                charger: charger,
                                isFeatured: true
                            )
                            .padding(.horizontal)
                            .padding(.top, 20)
                            
                            QuickStatsView()
                                .padding(.horizontal)
                            
                            RecentActivityView()
                                .padding(.horizontal)
                                .padding(.bottom, 30)
                        }
                    }
                    .transition(.asymmetric(
                        insertion: .move(edge: .leading).combined(with: .opacity),
                        removal: .move(edge: .trailing).combined(with: .opacity)
                    ))
                } else {
                    EmptyStateView()
                }
            }
        }
        .navigationDestination(for: NavigationDestination.self) { destination in
            switch destination {
            case .Charger:
                ChargerView(navigationPath: $navigationPath)
            case .AllChargersView:
                AllChargersView(navigationPath: $navigationPath)
            case .ChargerDetails(let charger):
                ChargerDetailsView(
                    navigationPath: $navigationPath,
                    charger: charger
                )
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack(spacing: 8) {
                    Image(systemName: "bolt.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.evcGreen)
                    Text("ChargeHub")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundColor(.white)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                ShowAllChargersButton()
            }
        }
        .toolbarBackground(Color(hex: "0A0E27"), for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    @ViewBuilder
    private func ShowAllChargersButton() -> some View {
        Button {
            log.info("Show all chargers tapped")
            navigationPath.append(NavigationDestination.AllChargersView)
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "square.grid.2x2")
                    .font(.system(size: 16, weight: .medium))
                Text("Show All")
                    .font(.system(size: 15, weight: .semibold))
            }
            .foregroundColor(.evcGreen)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .fill(Color.evcGreen.opacity(0.2))
            )
        }
    }
}

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 24) {
            ZStack {
                Circle()
                    .fill(Color.red.opacity(0.1))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "bolt.slash.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.red.opacity(0.8))
            }
            
            VStack(spacing: 12) {
                Text("No Chargers Found")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                Text("We couldn't find any chargers in your area.\nTry adjusting your search filters.")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
            }
            
            Button {
                log.info("Try again tapped")
            } label: {
                HStack {
                    Image(systemName: "arrow.clockwise")
                    Text("Try Again")
                }
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(
                    Capsule()
                        .fill(Color.evcGreen)
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct QuickStatsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Quick Stats")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white)
            
            HStack(spacing: 12) {
                StatCard(
                    icon: "bolt.circle.fill",
                    value: "147",
                    label: "kWh This Month",
                    color: .evcGreen
                )
                
                StatCard(
                    icon: "clock.fill",
                    value: "12.5",
                    label: "Hours Charged",
                    color: .blue
                )
                
                StatCard(
                    icon: "leaf.fill",
                    value: "89",
                    label: "kg CO₂ Saved",
                    color: .green
                )
            }
        }
    }
}

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(color)
            
            Text(value)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundColor(.white)
            
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.white.opacity(0.6))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
}

struct RecentActivityView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Recent Activity")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button {
                    log.info("View all tapped!")
                } label: {
                    Text("View All")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.evcGreen)
                }
            }
            
            VStack(spacing: 12) {
                ActivityRow(
                    location: "Downtown Station",
                    date: "Today, 2:30 PM",
                    energy: "45.2 kWh",
                    cost: "$12.50"
                )
                
                ActivityRow(
                    location: "Mall Parking B2",
                    date: "Yesterday, 6:15 PM",
                    energy: "28.7 kWh",
                    cost: "$8.20"
                )
            }
        }
    }
}

struct ActivityRow: View {
    let location: String
    let date: String
    let energy: String
    let cost: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.evcGreen.opacity(0.2))
                    .frame(width: 44, height: 44)
                
                Image(systemName: "bolt.fill")
                    .font(.system(size: 20))
                    .foregroundColor(.evcGreen)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(location)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.white)
                
                Text(date)
                    .font(.system(size: 14))
                    .foregroundColor(.white.opacity(0.6))
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text(cost)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.evcGreen)
                
                Text(energy)
                    .font(.system(size: 12))
                    .foregroundColor(.white.opacity(0.6))
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                )
        )
    }
}
